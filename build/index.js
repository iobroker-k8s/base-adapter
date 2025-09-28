#!/usr/bin/env node
"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.main = run;
const yargs_1 = __importDefault(require("yargs/yargs"));
const helpers_1 = require("yargs/helpers");
const argv = (0, yargs_1.default)((0, helpers_1.hideBin)(process.argv))
    .option('verbose', {
    alias: 'v',
    type: 'boolean',
    description: 'Run with verbose logging',
    default: false,
})
    .help()
    .alias('help', 'h')
    .env('IOB_K8S_')
    .parseSync();
function run() {
    console.log('ioBroker Kubernetes Controller');
    if (argv.verbose) {
        console.log('Verbose mode enabled');
        console.log('Arguments:', argv);
    }
}
if (require.main === module) {
    run();
}
//# sourceMappingURL=index.js.map