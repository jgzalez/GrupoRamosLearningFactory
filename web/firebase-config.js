// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyD6TilaiXuvr-aNYOJPw1s2qlryrjm3Ols",
    authDomain: "grupo-ramos--lf.firebaseapp.com",
    projectId: "grupo-ramos--lf",
    storageBucket: "grupo-ramos--lf.appspot.com",
    messagingSenderId: "392448934525",
    appId: "1:392448934525:web:32b0b8511b64289a39a714",
    measurementId: "G-FT78CRV82C"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);