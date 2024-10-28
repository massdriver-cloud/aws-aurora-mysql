#! /usr/bin/env ruby
require "yaml"
require "json"

$engine = "aurora-mysql"
$mdyaml = "massdriver.yaml"
$region = "us-east-1"

engines = `aws rds describe-db-engine-versions --engine aurora-mysql --region #{$region} --query 'DBEngineVersions'`

engines = JSON.parse(engines)
formatted_engines = engines.map do |engine|
  {
    "title" => engine["DBEngineVersionDescription"],
    "const" => engine["EngineVersion"]
  }
end

default = formatted_engines.last["const"]

conf = YAML.load(File.read($mdyaml))

conf["params"]["properties"]["database"]["properties"]["version"]["oneOf"] = formatted_engines
conf["params"]["properties"]["database"]["properties"]["version"]["default"] = default

File.write($mdyaml, conf.to_yaml)
