package cn.ky.jzk.swagger.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Swagger2Configuration
 *
 * @author jiazekai 2021年05月15日
 * @version V1.0
 * @modify by user: jiazekai 2021年05月15日 12:08
 */
@Configuration
@EnableSwagger2
public class Swagger2Configuration {

    public static final String SWAGGER_SCAN_BASE_PACKAGE = "cn.ky.jzk.controller";

    public static final String VERSION = "1.0.0";

    @Bean
    public Docket createRestApi() {
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .select()
                .apis(RequestHandlerSelectors.basePackage(SWAGGER_SCAN_BASE_PACKAGE))
                .paths(PathSelectors.any())
                .build()
                .groupName("开放接口分组");
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("智能化共享租赁平台")
                .description("智能化共享租赁平台 API 接口文档")
                .version(VERSION)
                .termsOfServiceUrl("https://www.apache.org/licenses/LICENSE-2.0.html")
                .build();
    }
}
