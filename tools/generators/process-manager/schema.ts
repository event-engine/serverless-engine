export interface Schema {
  service: string;
  name: string;
  event: string;
  isPublicEvent: "y" | "n";
  aggregate: string;
}
