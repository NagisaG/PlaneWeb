package com.gzl.config;

import com.gzl.CustomerInterceptor.CustomerInterceptor;
import com.gzl.cglib.MyAspect;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

/**
 * 名称:SpringMvcConfig
 * 描述:
 *
 * @version 1.0
 * @author:Nagisa
 * @datetime:2023-11-09 15:45
 */
@Configuration
@EnableAspectJAutoProxy
@ComponentScan({"com.gzl.controller", "com.gzl.cglib"})
@EnableWebMvc
public class SpringMvcConfig implements WebMvcConfigurer {
    @Bean
    MyAspect myLoginAspect(){
        return new MyAspect();
    }
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();//开启对静态资源的访问
    }
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry.addResourceHandler("/webapp/**")
                .addResourceLocations("classpath:/webapp/");
    }
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CustomerInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns("/checkLogin/tologin","/checkLogin/dopost","/checkLogin/doget","/WEB-INF/**","/plane/**","/type/**","/index/**"); // 排除不需要拦截的路径
    }

    @Bean
    public ViewResolver adminViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    @Bean
    public ViewResolver userViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/public/");
        resolver.setSuffix(".jsp");
        return resolver;
    }

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        registry.viewResolver(adminViewResolver());
        registry.viewResolver(userViewResolver());
    }
// public void configureViewResolvers(ViewResolverRegistry registry) {
//        registry.jsp("/WEB-INF/admin/",".jsp");
//    }
}
