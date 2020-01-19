package org.yugong.daemon;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.event.ContextRefreshedEvent;

import java.util.Arrays;
import java.util.LinkedHashSet;

/**
 * 入口类
 * @author 小天
 * @date 2020/1/19 20:28
 */
@SpringBootApplication
public class MainApp implements ApplicationListener<ContextRefreshedEvent> {

    public static final String SIG_START = "start";
    public static final String SIG_STOP  = "stop";

    private static ApplicationContext context;

    public static void main(String[] args) {
        Logger logger = LoggerFactory.getLogger(MainApp.class);

        LinkedHashSet<String> argSet = new LinkedHashSet<>(Arrays.asList(args));

        if (argSet.contains(SIG_START)) {
            // 收到启动信号
            logger.warn("Received '{}' signal", SIG_START);
            SpringApplication.run(MainApp.class, args);
        } else if (argSet.contains(SIG_STOP)) {
            // 收到停止信号
            logger.warn("Received '{}' signal", SIG_STOP);
            SpringApplication.exit(MainApp.context);
        } else {
            // 没有信号时，视为启动信号
            logger.warn("None signal AS {}", SIG_START);
            SpringApplication.run(MainApp.class, args);
        }
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
        ApplicationContext context = event.getApplicationContext();
        if (context.getParent() == null) {
            MainApp.context = context;
        }
    }
}
