export function is144(version: string): boolean {
    const versionMatch = version.match(/Terraria(\d+)/)
    const versionNumber = versionMatch?.[1];
    if (versionNumber && parseInt(versionNumber).toString() === versionNumber) {
        return parseInt(versionNumber) >= 269; // 1.4.4 +
    }

    return false;
}