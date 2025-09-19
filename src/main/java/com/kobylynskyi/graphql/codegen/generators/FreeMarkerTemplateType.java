package com.kobylynskyi.graphql.codegen.generators;

/**
 * Type of the FreeMarker template
 */
public enum FreeMarkerTemplateType {

    TYPE,
    TYPE_RECORD,
    ENUM,
    UNION,
    REQUEST,
    RESPONSE,
    INTERFACE,
    INTERFACE_RECORD,
    OPERATIONS,
    PARAMETRIZED_INPUT,
    RESPONSE_PROJECTION,
    JACKSON_TYPE_ID_RESOLVER

}
