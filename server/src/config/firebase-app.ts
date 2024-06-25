// Import the functions you need from the SDKs you need
import { initializeApp,getApp } from "firebase/app";
import {getStorage, ref} from "firebase/storage"
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyAm8svTwV8lMOJHin0nUH8a-tmXRuFI_M8",
  authDomain: "jim-hats.firebaseapp.com",
  projectId: "jim-hats",
  storageBucket: "jim-hats.appspot.com",
  messagingSenderId: "989821449537",
  appId: "1:989821449537:web:c1072d91796160588bddc0"
};

// Initialize Firebase
export const firebaseApp = initializeApp(firebaseConfig);
export const storage = getStorage(firebaseApp)
export const profilePicturesRef = ref(storage,"profile-pictures")