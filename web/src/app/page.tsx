import AuthScreen from "@/components/AuthScreen";

export const metadata = {
  title: "RentWise",
  description: "RentWise - Peer-to-Peer Rental Management Platform",
};

export default function Home() {
  return <AuthScreen initialMode="signin" />;
}
