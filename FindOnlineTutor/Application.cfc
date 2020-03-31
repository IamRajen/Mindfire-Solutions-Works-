<cfcomponent output="false">
	<cfset this.name = 'FindOnlineTutor' />
	<cfset this.applicationTimeout = createtimespan(0,2,0,0) />
	<cfset this.datasource = 'DatabaseFindOnlineTutor' />
	<cfset this.sessionManagement = true />
	<cfset this.sessionTimeout = createTimespan(0,0,30,0) />

	<!---OnApplicationStart() method--->
	<cffunction name="onApplicationStart" returntype="boolean" >
		<cfreturn true />
	</cffunction>

	<cffunction name="onRequestStart" returntype="boolean" >
		<cfargument name="targetPage" type="string" required="true" />
		<!---handle some special URL parameters--->
		<cfif isDefined('url.restartApp')>
			<cfset this.onApplicationStart() />
		</cfif>
		<cfreturn true />
	</cffunction>
	
</cfcomponent>