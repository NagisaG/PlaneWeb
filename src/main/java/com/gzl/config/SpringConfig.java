package com.gzl.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.annotation.Import;

/**
 * 名称:SpringConfig
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-09 15:46
 */
@Configuration
@EnableAspectJAutoProxy
@Import({MyBatisConfig.class, JdbcConfig.class})
@ComponentScan(value = "com.gzl.service")
public class SpringConfig {
}
