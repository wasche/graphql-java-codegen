<#assign MapperUtil=statics["com.kobylynskyi.graphql.codegen.java.JavaGraphQLTypeMapper"]>
<#if package?has_content>
package ${package};

</#if>
<#if imports??>
<#list imports as import>
import ${import}.*;
</#list>
</#if>
<#if toStringForRequest>
import com.kobylynskyi.graphql.codegen.model.graphql.GraphQLRequestSerializer;
</#if>
<#if toString>
import java.util.StringJoiner;
</#if>

<#if javaDoc?has_content>
/**
  <#list javaDoc as javaDocLine>
  * ${javaDocLine}
  </#list>
*/
</#if>
<#if generatedAnnotation && generatedInfo.getGeneratedType()?has_content>
@${generatedInfo.getGeneratedType()}(
  value = "com.kobylynskyi.graphql.codegen.GraphQLCodegen",
  date = "${generatedInfo.getDateTime()}"
)
</#if>
<#list annotations as annotation>
@${annotation}
</#list>
public record ${className} (
<#if fields?has_content>
    <#list fields as field>
        <#if field.deprecated?has_content>
          @${field.deprecated.annotation}
        </#if>
        <#list field.annotations as annotation>
          @${annotation}
        </#list>
        ${field.type} ${field.name}<#if !field?is_last>,</#if>
    </#list>
</#if>
) implements java.io.Serializable<#if implements?has_content><#list implements as interface>, ${interface}<#if interface_has_next></#if></#list></#if> {
<#if toString>
  @Override
  public String toString() {
  StringJoiner joiner = new StringJoiner(", ", "{ ", " }");
    <#if fields?has_content>
        <#list fields as field>
            <#if MapperUtil.isJavaPrimitive(field.type)>
                <#if toStringForRequest>
                  joiner.add("${field.originalName}: " + GraphQLRequestSerializer.getEntry(${field.name}<#if field.serializeUsingObjectMapper>, true</#if>));
                <#else>
                  joiner.add("${field.originalName}: " + ${field.name});
                </#if>
            <#else>
              if (${field.name} != null) {
                <#if toStringForRequest>
                  joiner.add("${field.originalName}: " + GraphQLRequestSerializer.getEntry(${field.name}<#if field.serializeUsingObjectMapper>, true</#if>));
                <#else>
                    <#if field.type == "String">
                      joiner.add("${field.originalName}: \"" + ${field.name} + "\"");
                    <#else>
                      joiner.add("${field.originalName}: " + ${field.name});
                    </#if>
                </#if>
              }
            </#if>
        </#list>
    </#if>
  return joiner.toString();
  }
</#if>
}
