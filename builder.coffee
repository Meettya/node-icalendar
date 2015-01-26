###
This is build file

to wipe out Gruntfile from realization 
###
async         = require 'async'
path          = require 'path'
fs            = require 'fs-extra'
{spawn, exec} = require 'child_process'
_             = require 'lodash'
Clinch        = require 'clinch'
UglifyJS      = require 'uglify-js'

packer = new Clinch

{get_pack_config} = require './pack_configurator'


compile_src = (file, result_dir, cb) ->

  filename = path.basename file, '.js'

  console.log "Building #{filename}"

  pack_config = get_pack_config filename

  async.auto

    build_data: (acb) ->
      packer.buldPackage pack_config, acb

    minify_data: ([ 'build_data', (acb, results) ->
      acb null, UglifyJS.minify results.build_data, fromString: true
    ])

    save_full: ([ 'build_data', (acb, results) ->
      console.log '    - save full'
      fs.outputFile "#{path.join result_dir, filename}.js", results.build_data, encoding:'utf8', acb
    ])

    save_minify: ([ 'minify_data', (acb, results) ->
      console.log '    - save minify'
      fs.outputFile "#{path.join result_dir, filename}.min.js", results.minify_data.code, encoding:'utf8', acb
    ])

    , (err) ->
      cb err, "Compiled #{filename}.js + #{filename}.min.js"


source_filename = path.join __dirname, 'index.js'
result_dir      = path.join __dirname, 'dist'


compile_src source_filename, result_dir, (err, text) ->
  throw err if err?
  console.log text

