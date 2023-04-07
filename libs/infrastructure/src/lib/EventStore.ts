import {Event, EventMeta} from "@app/messaging/event";

export enum MatchOperator {
    EQ = '===',
    GT = '>',
    GTE = '>=',
    LT = '<',
    LTE = '<=',
}

export interface MatchObject {op: MatchOperator, val: string | number | boolean}

export interface MetadataMatcher {
    [metadataKey: string]: string | MatchObject;
}

export function checkMatchObject(matcher: string | MatchObject): MatchObject {
    if(typeof matcher !== "object") {
        return {op: MatchOperator.EQ, val: matcher};
    }

    return matcher;
}

export type AppendToListener = (streamName: string, events: Event[]) => void;

export type StreamType = "write-model" | "public";

export interface EventStore {
    hasStream: (streamName: string) => Promise<boolean>;
    /**
     * @param streamName string Name of the stream
     * @param type StreamType Type of the stream, defaults to "write-model"
     */
    createStream: (streamName: string, type?: StreamType) => Promise<boolean>;
    deleteStream: (streamName: string) => Promise<boolean>;
    appendTo: (streamName: string, events: Event[], metadataMatcher?: MetadataMatcher, expectedVersion?: number) => Promise<boolean>;
    load: <P = any, M extends EventMeta = any>(streamName: string, metadataMatcher?: MetadataMatcher, fromEventId?: string, limit?: number) => Promise<AsyncIterable<Event<P,M>>>;
    attachAppendToListener: (listener: AppendToListener) => void;
    detachAppendToListener: (listener: AppendToListener) => void;
}
