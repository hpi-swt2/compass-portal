import * as polylabel from 'polylabel';

let map;
let routeLayer;
let pinIcons = [
    L.divIcon({
        iconSize: null,
        html: "<div style='' class='pin-icon1'></div>",
    }),
    L.divIcon({
        iconSize: null,
        html: "<div style='' class='pin-icon2'></div>",
    })
];
export let pins = [];
let layerControl;
/**
 * defines the floor that is currently displayed
 */
let currentFloor = 0;
/**
 * object that contains for each existing floor two layer groups, one for rooms and one for labels
 */
const floors = {};


export async function setupMap() {
    map = L.map("map");
    layerControl = L.control.layers({}, {}).addTo(map);
    // add a title to the leaflet layer control
    $('<h6>Floors</h6>').insertBefore('div.leaflet-control-layers-base');

    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution:
            '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> | Crosshairs icon by <a href="https://fontawesome.com/license/free">Font Awesome</a>',
        maxZoom: 22,
        maxNativeZoom: 19
    }).addTo(map);

    const [view, buildingPolygons, buildingMarkers] = await Promise.all([
        getView(),
        getBuildings(),
        getBuildingMarkers(),
    ]);
    setView(view);
    addTargetMarker();
    addPolygons(buildingPolygons);
    addMarkers(buildingMarkers);

    // display indoor information eg. rooms, labels
    loadGeoJsonFile('assets/ABC-Building-0.geojson');
    loadGeoJsonFile('assets/ABC-Building-1.geojson');
    map.on('zoomend', recalculateTooltipVisibility);
    map.on('baselayerchange', (event) => {
        currentFloor = parseInt(event.name);
        recalculateTooltipVisibility();
    });

    // Add pins on click
    map.on("click", onClick);
}

function addPin(e, pinNumber) {
    pins[pinNumber] = L.marker(e.latlng, {icon: pinIcons[pinNumber]});
    pins[pinNumber].addTo(map);
    pins[pinNumber].on("click", function(e) {
        removePin(pinNumber);
    });
}

function removePin(pinNumber){
    pins[pinNumber].remove();
    pins[pinNumber] = null;
}

function removeAllPins() {
    for(let i=0; i<pins.length; i++){
        removePin(i);
    }
}

function onClick(e) {
    if(!pins[0] || pins[0]===null){
        addPin(e, 0);
    }else if(!pins[1] || pins[1]===null){
        addPin(e, 1);
    }else{
        removeAllPins();
    }
}

function addTargetMarker() {
    const params = new URLSearchParams(window.location.search);
    if (!params.has("target")) return
    const target = params.get("target");
    const coordinates = target.split(",");

    const marker = {
        latlng: coordinates,
        divIcon: {
            html: "<img src='/assets/pin.png'>",
            className: "target-pin",
        },
    };

    addMarker(marker, map);
    setView({ latlng: coordinates, zoom: 19 });
}

export function setView(view) {
    map.setView(view["latlng"], view["zoom"]);
}

export function addPolygons(polygons) {
    polygons.forEach((polygon) => {
        L.polygon(polygon["latlngs"], polygon["options"]).addTo(map);
    });
}

export function addMarkers(markers, layer = map) {
    markers.forEach((marker) => {
        addMarker(marker, layer);
    });
}

export function addMarker(marker, layer = map) {
    marker["divIcon"]["iconSize"] = [];
    marker["divIcon"]["iconAnchor"] = [0, 0];
    marker["divIcon"]["popupAnchor"] = [0, 0];
    const icon = L.divIcon(marker["divIcon"]);
    L.marker(marker["latlng"], { icon: icon }).addTo(layer);
}

export function addAnyMarker(marker, layer = map) {
    marker.addTo(layer);
}

export function addPolylines(polylines, layer = map) {
    polylines.forEach((polyline) => {
        addPolyline(polyline, layer);
    });
}

export function addPolyline(polyline, layer = map) {
    L.polyline(polyline["latlngs"], polyline["options"]).addTo(layer);
}

export async function displayRoute(start, dest) {
    const route = await $.ajax({
        type: "GET",
        url: "/building_map/route",
        data: `start=${start}&dest=${dest}`,
        dataType: "json",
    });
    if (routeLayer) routeLayer.clearLayers();
    else routeLayer = L.layerGroup();
    addPolyline(route["polyline"], routeLayer);
    addMarkers([route["marker"]], routeLayer);
    routeLayer.addTo(map);
}

async function getBuildings() {
    return $.ajax({
        type: "GET",
        url: "/building_map/buildings",
        dataType: "json",
    });
}

async function getBuildingMarkers() {
    return $.ajax({
        type: "GET",
        url: "/building_map/markers",
        dataType: "json",
    });
}

async function getView() {
    return $.ajax({
        type: "GET",
        url: "/building_map/view",
        dataType: "json",
    });
}

function setupGeoJsonFeature(feature, layer) {
    const level = parseInt(feature.properties.level_name);

    if (isNaN(level)) {
        console.warn("feature has no valid level name and will be skipped: ", feature.properties.level_name, feature);
        return;
    }

    if (!floors[level]) {
        floors[level] = { rooms: L.layerGroup(), labels: L.layerGroup() };
        const newLayer = L.layerGroup([floors[level].rooms, floors[level].labels]);
        layerControl.addBaseLayer(newLayer, feature.properties.level_name);
        // We add the current floor to the map here so that the map and layer control reference the same object 
        // now the layer control will select the correct check box automatically
        if (level === currentFloor) {
            newLayer.addTo(map);
        }
    }

    floors[level].rooms.addLayer(layer);

    // find a position, create an invisible marker and bind a tooltip to it
    // we do not bind the tooltip to the room because you can only change the position of a tooltip by defining an offset
    // to the referenced object (you cannot give it a coordinate), we would need to determine an offset for each room

    // used for polylabel to estimate the visual center of a polygon that is inside of the polygon
    // lower value -> higher precision
    const markerPositionPrecision = 0.000001;
    const markerPosition = polylabel(feature.geometry.coordinates, markerPositionPrecision);

    const label = L.circleMarker({ lat: markerPosition[1], lng: markerPosition[0] }, { opacity: 0, radius: 0, fill: false }).bindTooltip(
        feature.properties.name,
        {
            permanent: true,
            direction: 'center',
            className: 'indoor-label',
        }
    )

    floors[level].labels.addLayer(label);
    label.closeTooltip();
}

async function loadGeoJsonFile(filename) {
    const file = await fetch(filename);
    const geojsonFeatureCollection = await file.json();
    // the gejson files contain points for certain properties eg. doors, however we have not implemented the visualization of those and filter them here
    L.geoJSON(geojsonFeatureCollection, { onEachFeature: setupGeoJsonFeature, filter: (feature => feature.geometry.type != "Point") });
}

function recalculateTooltipVisibility() {
    const zoomLevel = map.getZoom()
    if (zoomLevel >= 20) {
        floors[currentFloor].labels.eachLayer(layer => layer.openTooltip());
    } else {
        floors[currentFloor].labels.eachLayer(layer => layer.closeTooltip());
    }

    if (zoomLevel <= 17) {
        floors[currentFloor].rooms.removeFrom(map);
    } else {
        floors[currentFloor].rooms.addTo(map);
    }
}

// Returns a modified version of `f` that only runs if the last call is longer
// than `limit` ms ago.
export function ratelimit(f, limit) {
    let locked = false;
    return (...args) => {
        if (!locked) {
            locked = true;
            setTimeout(() => locked = false, limit);
            return f(...args);
        }
    };
}

// Returns a function that calls return the value returned by `initializer`.
// Repeated calls return the same value returned by the first call.
// In order to work properly, `initializer` should not return `null`.
export function lazyInit(initializer) {
    let value = null;
    return () => {
        if (value === null) {
            value = initializer();
        }
        return value;
    };
}
