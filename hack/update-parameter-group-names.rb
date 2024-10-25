#! /usr/bin/env ruby
require "yaml"
require "json"

$mdyaml = "massdriver.yaml"

def read_file_to_array(file_path)
  File.readlines(file_path).map(&:strip).reject(&:empty?)
end

script_dir = File.dirname(__FILE__)
cluster_level_params = read_file_to_array(File.join(script_dir, "parameter-names-cluster-level.txt"))
instance_level_params = read_file_to_array(File.join(script_dir, "parameter-names-instance-level.txt"))

conf = YAML.load(File.read($mdyaml))

conf["params"]["properties"]["parameter_groups"]["properties"]["cluster_parameters"]["items"]["properties"]["name"]["enum"] = cluster_level_params
conf["params"]["properties"]["parameter_groups"]["properties"]["instance_parameters"]["items"]["properties"]["name"]["enum"] = instance_level_params

File.write($mdyaml, conf.to_yaml)
