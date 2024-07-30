import { API_URL } from "@/constants";

export async function joinChallenge(joinId: string,token:string) {
  const response = await fetch(`${API_URL}`, {
    method: "GET",
  });
  if (!response.ok) {
    throw new Error("Failed to join challenge");
  }
  return response.json();
}