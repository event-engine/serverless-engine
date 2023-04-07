export const normalizeEventName = (name: string): string => {
  return name.split(".").pop() || '';
}
