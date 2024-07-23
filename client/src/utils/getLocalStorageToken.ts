"use client";
export function getLocalStorageToken() {
    return typeof window !== "undefined" ? localStorage.getItem("token") : null;
}