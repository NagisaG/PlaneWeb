package com.gzl.config;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperScannerConfigurer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;
import java.io.IOException;

/**
 * 名称:MyBatisConfig
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-09 15:47
 */
@Configuration
public class MyBatisConfig {
    @Bean
    public static SqlSessionFactoryBean getSqlSessionFactoryBean(@Autowired DataSource dataSource) throws IOException {
        SqlSessionFactoryBean ssfb=new SqlSessionFactoryBean();
        ssfb.setDataSource(dataSource);
        ssfb.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("file:"));
        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
        ssfb.setConfiguration(configuration);

        // 设置log4j作为日志实现
        configuration.setLogImpl(org.apache.ibatis.logging.log4j.Log4jImpl.class);
        return ssfb;
    }
    @Bean
    public static MapperScannerConfigurer getMapperScannerConfigurer(){
        MapperScannerConfigurer msc=new MapperScannerConfigurer();
        msc.setBasePackage("com.gzl.mapper");

        return msc;
    }
}

//@Configuration
//public class MyBatisConfig {
//    @Bean
//    public SqlSessionFactoryBean getSqlSessionFactoryBean(@Autowired DataSource dataSource) throws IOException {
//        SqlSessionFactoryBean ssfb=new SqlSessionFactoryBean();
//        ssfb.setDataSource(dataSource);
//        ssfb.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("file:E:/Codes/Java/JavaEE/JavaEE/DataBinding_1/src/main/resources/mapper/AdminMapper.xml"));
//        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
//        ssfb.setConfiguration(configuration);
//
//        // 设置log4j作为日志实现
//        configuration.setLogImpl(org.apache.ibatis.logging.log4j.Log4jImpl.class);
//        return ssfb;
//    }
//    @Bean
//    public MapperScannerConfigurer getMapperScannerConfigurer(){
//        MapperScannerConfigurer msc=new MapperScannerConfigurer();
//        msc.setBasePackage("com.gzl.mapper");
//
//        return msc;
//    }
//}
