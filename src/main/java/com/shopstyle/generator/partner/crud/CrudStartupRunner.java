package com.shopstyle.generator.partner.crud;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.util.StringUtils;

@Component
public class CrudStartupRunner implements ApplicationRunner {

    private static final Logger logger = LoggerFactory.getLogger(CrudStartupRunner.class);

    @Value("${target.object}")
    private String targetObject;

    @Value("${dest.dir}")
    private String destDir = "out";

    @Autowired
    private Configuration freemarkerConfig;

    private File writeSrcFile(File destDir, String fileName, String templateName,
            Map<String, Object> model) throws IOException, TemplateException {
        Template t = freemarkerConfig.getTemplate(templateName);
        String src = FreeMarkerTemplateUtils.processTemplateIntoString(t, model);
        File file = new File(destDir, fileName + ".java");
        try (FileWriter fw = new FileWriter(file)) {
            fw.write(src);
            fw.flush();
        } catch (IOException e) {
            logger.error("Issue writing file", e);
        }
        logger.info("Wrote file {}", file.getPath());
        return file;

    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        logger.info("Application started with command-line arguments: {}",
                Arrays.toString(args.getSourceArgs()));

        if (!args.containsOption("target.object")) {
            System.out.println("Must supply target.object: i.e. --target.object=InfluencerSignUp");
            System.exit(1);
        }

        File destDir = new File(this.destDir);
        if (destDir.exists()) {
            destDir.delete();
        }
        destDir.mkdir();

        String titleCase = StringUtils.capitalize(targetObject);
        String camelCase = StringUtils.uncapitalize(targetObject);

        Map<String, Object> model = new HashMap() {{
            put("titleCaseObject", titleCase);
            put("camelCaseObject", camelCase);
        }};
        writeSrcFile(destDir, titleCase + "ServiceImpl", "client.ftl", model);
        writeSrcFile(destDir, titleCase + "Service", "service.ftl", model);
        writeSrcFile(destDir, titleCase + "Repository", "repository.ftl", model);
        writeSrcFile(destDir, "Extended" + titleCase + "Service", "extendedService.ftl", model);
        writeSrcFile(destDir, titleCase + "sApi", "api.ftl", model);
    }
}