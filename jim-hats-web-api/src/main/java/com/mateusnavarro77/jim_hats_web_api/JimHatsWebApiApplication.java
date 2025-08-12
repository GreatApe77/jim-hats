package com.mateusnavarro77.jim_hats_web_api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = {
		org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration.class,
		org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration.class
})
public class JimHatsWebApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(JimHatsWebApiApplication.class, args);
	}

}
