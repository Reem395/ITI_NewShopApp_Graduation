const firebase = require("firebase");
// Required for side-effects
require("firebase/firestore");

// Initialize Cloud Firestore through Firebase
firebase.initializeApp({
    apiKey: "shopappmain",
    authDomain: "<YOUR AUTH DOMAIN>",
    projectId: "<YOUR PROJECT ID>"
});

var db = firebase.firestore();