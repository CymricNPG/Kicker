
hibernate {
	cache.use_second_level_cache=true
	cache.use_query_cache=true
	cache.provider_class='net.sf.ehcache.hibernate.EhCacheProvider'
}
// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "update" //"create-drop" // one of 'create', 'create-drop','update'
			url = "jdbc:h2:file:kickerDb"
			pooled = true
			driverClassName = "org.h2.Driver"
			username = "sa"
			password = ""
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:h2:mem:testDb"
			pooled = true
			driverClassName = "org.h2.Driver"
			username = "sa"
			password = ""
		}
	}
	production {
		dataSource {
			dbCreate = "update"
			driverClassName = "com.myorg.jdbcDriverNotExists"
			url = ""
			username = ""
			password = ""
		}
	}
	
	//	production {
	//		dataSource {
	//			dbCreate = "update"
	//			url = "jdbc:hsqldb:file:///tmp/kickerDb;shutdown=true"
	//		}
	//	}
}