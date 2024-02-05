#!/usr/bin/env node

const { execSync } = require("child_process");
const fs = require("fs");
const os = require("os");
const path = require("path");

const { argv } = require("yargs")
  .scriptName(path.basename(__filename))
  .usage("Usage $0 -d string -o string")
  .option("d", {
    alias: "documentPath",
    describe: "Path to the graphql documents to generate API.",
    default: "documents/**/*.graphql",
    type: "string",
    nargs: 1,
  })
  .option("o", {
    alias: "outputPath",
    describe: "Path to output the generated swift file.",
    default: "../SudoIdentityVerification/Source/Internal/Utility/SudoIdentityVerificationServiceAPI.swift",
    type: "string",
    nargs: 1,
  });

const documentsPattern = argv.d;
const apiFile = argv.o;

const schemaFile = "introspection.json";
const disableSwiftLintRule = "// swiftlint:disable all";
const enableSwiftLintRule = "// swiftlint:enable all";

/*******************************************************************************
 * Main
 ******************************************************************************/

// Run initial code generation to generate the introspection file
execSync("graphql-codegen -c codegen.yml");

// Move the introspection file to a tmp directory
const tmpDir = fs.mkdtempSync(path.join(os.tmpdir(), "graphql-codegen"));
const schemaPath = path.join(tmpDir, schemaFile);
fs.renameSync(schemaFile, schemaPath);

// Run the swift code generation.
const command = `aws-appsync-codegen generate ${documentsPattern} --schema ${schemaPath} --output ${apiFile}`;
console.log(`invoking: ${command}`);
execSync(command);

// Load the file as a string
let fileAsString = fs.readFileSync(apiFile, "utf-8");

// Add swiftlint disable rule
fileAsString = `${disableSwiftLintRule}\n${fileAsString}\n${enableSwiftLintRule}\n`;

fileAsString = fileAsString
  // Replace all public with internal
  .replace(/\bpublic\b/g, "internal")
  // Add wrapping GraphQL struct to namespace
  .replace("import AWSAppSync\n", "import AWSAppSync\n\nstruct GraphQL {\n")
  .concat("\n}");

// Write updated string back to file
fs.writeFileSync(apiFile, fileAsString, "utf-8");
