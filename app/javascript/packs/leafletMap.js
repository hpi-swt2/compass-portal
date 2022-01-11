let map;
let routeLayer;
let positionIcon;
let positionMarker;
let watcher_id;
let currentLocation;

export async function setupMap() {
    map = L.map("map");
    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution:
            '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> | Location icon from <a href="http://www.onlinewebfonts.com/icon">Icon Fonts</a> licensed by CC BY 3.0',
        maxZoom: 19,
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

    // Add indoor labels
    loadGeoJsonFile("assets/lecture-hall-building.geojson");
    map.on("zoomend", recalculateTooltipVisibility);

    positionIcon = L.icon({ iconUrl: "assets/location-icon.png", iconSize: [37.5, 50], iconAnchor: [18.75, 50] });
    positionMarker = L.marker([0, 0], { icon: positionIcon }).bindPopup("Your position");
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

function addIndoorLabel(feature, layer) {
    layer.bindTooltip(feature.properties.name, {
        permanent: true,
        direction: "center",
        className: "indoor-label",
    });
}

function loadGeoJsonFile(filename) {
    fetch(filename)
        .then((response) => response.json())
        .then((geojsonFeatureCollection) => {
            // Manually add indoor labels to map
            const rooms = L.geoJSON(geojsonFeatureCollection, {
                onEachFeature: addIndoorLabel,
            }).addTo(map);
            rooms.eachLayer((layer) => {
                layer.getTooltip().setLatLng(layer.getBounds().getCenter());
            });
            recalculateTooltipVisibility();
        });
}

function recalculateTooltipVisibility() {
    const zoomLevel = map.getZoom();
    map.eachLayer((layer) => {
        if (layer.getTooltip()) {
            if (zoomLevel == 19 /* nearest zoom */) {
                layer.openTooltip(layer.getBounds().getCenter());
            } else {
                layer.closeTooltip();
            }
        }
    });
}

const syncPositionWithLiveServerImpl = async (location) => {
    // FIXME: use logged in user instead of sending id
    const body = new URLSearchParams({ user: 1, location });
    const response = await fetch("/users/geo_location", { method: "PUT", body });
    console.assert(response.status === 204); // HTTP "No content"
};
const syncPositionWithLiveServer = ratelimit(syncPositionWithLiveServerImpl, 10000);

export function trackingHandler() {
    const tracking_switch = document.getElementById("tracking_switch");
    if (tracking_switch.checked) {
        positionMarker.addTo(map);
        watcher_id = navigator.geolocation.watchPosition(
            (pos) => {
                currentLocation = String(pos.coords.latitude) + "," + String(pos.coords.longitude);
                positionMarker.setLatLng([pos.coords.latitude, pos.coords.longitude]);
                syncPositionWithLiveServer(currentLocation);
            },
            (error) => {
                alert("We cannot determine your location. Maybe you are not permitting your browse r to determine your location.");
            }
        );
    } else {
        navigator.geolocation.clearWatch(watcher_id);
        positionMarker.remove();
    }
}

// Returns a modified version of `f` that only runs if the last call is longer
// than `limit` ms ago.
function ratelimit(f, limit) {
    let locked = false;
    return (...args) => {
        if (!locked) {
            locked = true;
            setTimeout(() => locked = false, limit);
            return f(...args);
        }
    };
}
