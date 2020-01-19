package org.yugong.daemon.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author 小天
 * @date 2020/1/19 20:40
 */
@Controller
public class IndexController {

    @ResponseBody
    @RequestMapping(path = {"/", "index.htm"})
    public String index() {
        return "Welcome to springboot windows service example";
    }
}
