#!/usr/bin/env node

import yargs from 'yargs/yargs';
import { hideBin } from 'yargs/helpers';

const argv = yargs(hideBin(process.argv))
    .option('verbose', {
        alias: 'v',
        type: 'boolean',
        description: 'Run with verbose logging',
        default: false,
    })
    .option('adapter', {
        alias: 'a',
        type: 'string',
        description: 'Specify the adapter to use',
        demandOption: true,
    })
    .option('instance', {
        alias: 'i',
        type: 'number',
        description: 'Specify the instance number to use',
        demandOption: true,
    })
    .help()
    .alias('help', 'h')
    .env('IOB_K8S_')
    .parseSync();

function run(): void {
    console.log(`ioBroker Kubernetes Adapter Helper for ${argv.adapter}.${argv.instance}`);

    if (argv.verbose) {
        console.log('Verbose mode enabled');
        console.log('Arguments:', argv);
    }
}

if (require.main === module) {
    run();
}

export { run as main };
