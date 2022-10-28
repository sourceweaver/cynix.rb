fs = require 'fs'
{ resolve } = require 'path'

parser = require './parser_generator/parser.g'

input_file = process.argv[2]
output_file = process.argv[3]

unless input_file? and output_file?
    console.error "Error: You need to specify both an input and output file"
    console.info  "Usage example:\n`coffee parser.coffee data/source.syn data/out.json`"
    process.exit 1

input_path  = resolve(process.cwd(), input_file)
output_path = resolve(process.cwd(), output_file)

fs.readFile(input_path, (err, data) ->
    console.error("Error: Could not read source file.\n #{err}") if err
    content = data.toString()
    parsed  = parser.parse(content)
    console.info "Successfully parsed source code:\n#{input_path}"

    write_data = JSON.stringify({parsed}, null, 2)
    fs.writeFile(output_path, write_data, (err) ->
        console.error("Error: Could not write to output file.\n #{err}") if err
    )
    console.info "Successfully written to JSON:\n#{output_path}"
)
