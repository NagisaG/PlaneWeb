package com.gzl.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

/**
 * 名称:ServletContainersInitConfig
 * 描述:初始化Servlet容器类的配置类
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-09 15:40
 */
public class ServletContainersInitConfig extends AbstractAnnotationConfigDispatcherServletInitializer {
    @Override
    //加载Spring配置类中的信息，初始化Spring容器
    protected Class<?>[] getRootConfigClasses() {
        return new Class[]{SpringConfig.class};
    }

    @Override
    //加载SpringMvc配置类的信息，初始化SpringMvc容器
    protected Class<?>[] getServletConfigClasses() {
        return new Class[]{SpringMvcConfig.class};
    }

    @Override
    //配置DispatcherServlet的映射路径
    protected String[] getServletMappings() {
        return new String[]{"/"};
    }
}
