<#--

    Copyright MapStruct Authors.

    Licensed under the Apache License version 2.0, available at http://www.apache.org/licenses/LICENSE-2.0

-->
<#-- @ftlvariable name="" type="org.mapstruct.ap.internal.model.assignment.ExistingInstanceSetterWrapperForCollectionsAndMaps" -->
<#import "../macro/CommonMacros.ftl" as lib>
<@lib.sourceLocalVarAssignment/>
<@lib.handleExceptions>
  if ( ${ext.targetBeanName}.${ext.targetReadAccessorName} != null ) {
    <@lib.handleLocalVarNullCheck needs_explicit_local_var=false cleanBefore=true ; sourcePresent>
      <#if !sourcePresent??>
        ${ext.targetBeanName}.${ext.targetReadAccessorName}.<#if ext.targetType.mapType>putAll<#else>addAll</#if>( <@lib.handleWithAssignmentOrNullCheckVar/> );
      <#elseif !sourcePresent>
        <#if !ext.defaultValueAssignment?? && !sourcePresenceCheckerReference?? && includeElseBranch><#-- the opposite (defaultValueAssignment) case is handeld inside lib.handleLocalVarNullCheck -->
          ${ext.targetBeanName}.${ext.targetWriteAccessorName}<@lib.handleWrite><#if mapNullToDefault><@lib.initTargetObject/><#else>null</#if></@lib.handleWrite>;
        </#if>
      <#elseif ext.targetType.setType || ext.targetType.mapType>
        ${ext.targetBeanName}.${ext.targetReadAccessorName}.<#if ext.targetType.mapType>entrySet().</#if>retainAll( <@lib.handleWithAssignmentOrNullCheckVar/><#if sourceType.mapType>.entrySet()</#if> );
      <#else>
        ${ext.targetBeanName}.${ext.targetReadAccessorName}.clear();
      </#if>
    </@lib.handleLocalVarNullCheck>
  }
  else {
      <@callTargetWriteAccessor/>
  }
</@lib.handleExceptions>
<#--
  assigns the target via the regular target write accessor (usually the setter)
-->
<#macro callTargetWriteAccessor>
  <@lib.handleLocalVarNullCheck needs_explicit_local_var=directAssignment cleanBefore=false>
    ${ext.targetBeanName}.${ext.targetWriteAccessorName}<@lib.handleWrite><#if directAssignment><@wrapLocalVarInCollectionInitializer/><#else><@lib.handleWithAssignmentOrNullCheckVar/></#if></@lib.handleWrite>;
  </@lib.handleLocalVarNullCheck>
</#macro>
<#--
  wraps the local variable in a collection initializer (new collection, or EnumSet.copyOf)
-->
<#macro wrapLocalVarInCollectionInitializer><@compress single_line=true>
    <#if enumSet>
      EnumSet.copyOf( ${nullCheckLocalVarName} )
    <#else>
      new <#if ext.targetType.implementationType??><@includeModel object=ext.targetType.implementationType/><#else><@includeModel object=ext.targetType/></#if>( ${nullCheckLocalVarName} )
    </#if>
</@compress></#macro>