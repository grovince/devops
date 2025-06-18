package com.springdemo.bootboard.config;

import java.nio.charset.Charset;

import jakarta.servlet.Filter; // javax.servlet → jakarta.servlet

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.filter.HiddenHttpMethodFilter;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.springdemo.bootboard.security.SpringBoardUserDetailsService;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Bean
    public Filter characterEncodingFilter() {
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        return filter;
    }

    @Bean
    public HttpMessageConverter<String> responseBodyConverter() {
        return new StringHttpMessageConverter(Charset.forName("UTF-8"));
    }

    // 파일 업로드용 CommonsMultipartResolver (주석 해제 시)
    // @Bean
    // public CommonsMultipartResolver multipartResolver() {
    //     CommonsMultipartResolver resolver = new CommonsMultipartResolver();
    //     resolver.setDefaultEncoding("UTF-8");
    //     resolver.setMaxUploadSize(1024 * 1024 * 5);
    //     return resolver;
    // }

    @Bean
    public HiddenHttpMethodFilter methodFilter() {
        return new HiddenHttpMethodFilter();
    }

    @Bean
    public SpringBoardUserDetailsService userDetailService() {
        return new SpringBoardUserDetailsService();
    }
}
