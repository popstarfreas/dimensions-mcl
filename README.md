# Dimensions-PlayerInfo
Currently uses a custom Dimensions node_modules folder for tests to work properly; this is currently not included in the source. Trying to work out specifics to resolve this.

To make the tests work:
 * Make a folder in node_modules called dimensions
 * Copy all files from `build\node_modules\dimensions` in a release of dimensions into the new dimensions folder
 * Copy the dimensions.d.ts into that same folder
 * Copy the package.json into that same folder
 
