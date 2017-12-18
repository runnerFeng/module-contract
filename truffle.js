module.exports = {
    build: {
        "index.html": "index.html",
        "app.js": [
            "javascripts/app.js"
        ],
        "app.css": [
            "stylesheets/app.css"
        ],
        "images/": "images/"
    },
    rpc: {
        from: "0xc5fa7cf57988d6946b296faed511bdfa16eca6bd",
        host: "10.10.8.14",
        port: 6789,
        gas: 999999999999
    }
};
