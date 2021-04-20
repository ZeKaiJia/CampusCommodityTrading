package cn.ky.jzk;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * @author kevin
 */
@Slf4j
@EnableScheduling
@ServletComponentScan
@SpringBootApplication
@EnableTransactionManagement
@MapperScan("cn.ky.jzk.mapper")
public class Application {
    public static void main(String[] args) {
        log.info("Programme start.");
        SpringApplication.run(Application.class, args);
        log.info("Programme end.");
    }
}
