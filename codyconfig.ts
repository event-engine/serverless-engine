import {Map} from "immutable";
import {onBoundedContext} from "./tools/codyhooks/on-bounded-context";
import {onAggregate} from "./tools/codyhooks/on-aggregate";
import {onCommand} from "./tools/codyhooks/on-command";
import {onEvent} from "./tools/codyhooks/on-event";
import {onDocument} from "./tools/codyhooks/on-document";

module.exports = {
    context: {
        /*
         * The context object is passed to each hook as second argument
         * use it to pass configuration to your hooks like a src directory, credentials, ...
         */
        // This Cody server implements the optional Sync flow and stores all synced nodes in this context property
        syncedNodes: Map({})
    },
    hooks: {
        /**
         * Uncomment and implement a hook to activate it
         */
        onAggregate,
        onBoundedContext,
        onCommand,
        onDocument,
        onEvent,
        // onFeature: onFeatureHook,
        // onFreeText: onFreeTextHook,
        // onExternalSystem: onExternalSystemHook,
        // onIcon: onIconHook,
        // onImage: onImageHook,
        // onHotSpot: onHotSpotHook,
        // onLayer: onLayerHook,
        // onPolicy: onPolicyHook,
        // onRole: onRoleHook,
        // onUi: onUiHook,
    }
}
