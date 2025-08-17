<#function url_changer url block>
  <#if url == "">
    <#return "/">
  <#else>
    <#return url?replace("*",block)>
  </#if>
</#function>
