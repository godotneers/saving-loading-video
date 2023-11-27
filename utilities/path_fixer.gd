class_name PathFixer

## This holds a dictionary of paths to replace in the input file
const Mappings = {
}

## Fixes paths referenced in the input file. Writes
## a new file to a temporary location and returns the
## path to that file.
static func fix_paths(inputPath:String) -> String:
	var text = FileAccess.get_file_as_string(inputPath)
	if text == "":
		push_error("Failed to read file: " + inputPath)
		return ""
		
	var result = text
	for search in Mappings:
		var replace = Mappings[search]
		result = result.replace(search, replace)
	
	# make a folder in the user directory to store temporary files
	DirAccess.make_dir_recursive_absolute("user://_res_fixer")
	# generate a random file name, it's not UUID but it's good enough
	var name = (str(Time.get_ticks_msec()) + str(randi())).md5_text() + ".tres"
	
	# write patched resource back to temp file
	var final_name = "user://_res_fixer/" + name
	var file = FileAccess.open(final_name, FileAccess.WRITE)
	file.store_string(result)
	file.close()

	return final_name
