import yargs from 'yargs/yargs';
import { hideBin } from 'yargs/helpers';
import { Install } from '@iobroker/js-controller-cli/build/esm/lib/setup/setupInstall';
import { dbConnectAsync } from '@iobroker/js-controller-cli';

async function run(): Promise<void> {
    await yargs(hideBin(process.argv))
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
        .command(
            ['add', 'a'],
            'Add a new adapter',
            () => {},
            async (argv) => {
                console.log(`Adding new adapter: ${argv.adapter}.${argv.instance}`);
                const { states, objects } = await dbConnectAsync(false, {});
                const installer = new Install({
                    states,
                    objects,
                    params: {},
                    processExit: process.exit,
                });
                await installer.installAdapter(argv.adapter);
                await installer.createInstance(argv.adapter, {
                    instance: argv.instance,
                });
                await states.destroy();
                await objects.destroy();
            }
        )
        .command(
            ['delete', 'del'],
            'Delete an existing adapter',
            () => {},
            async (argv) => {
                console.log(`Deleting adapter: ${argv.adapter}.${argv.instance}`);
                const { states, objects } = await dbConnectAsync(false, {});
                const installer = new Install({
                    states,
                    objects,
                    params: {},
                    processExit: process.exit,
                });
                await installer.deleteInstance(argv.adapter, argv.instance);
                await states.destroy();
                await objects.destroy();
            }
        )
        .demandCommand(1, 1)
        .strictCommands()
        .parse();
}

run().catch((error) => {
    console.error('Error occurred:', error);
    process.exit(1);
});
