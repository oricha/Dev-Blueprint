package com.karel.springcucumberblueprint.cucumber;

import java.io.*;
import java.nio.charset.StandardCharsets;

import org.springframework.http.client.ClientHttpResponse;

public class ResponseResults {
    private final ClientHttpResponse theResponse;
    private final String body;

    ResponseResults(final ClientHttpResponse response) throws IOException {
        this.theResponse = response;
        try (InputStream bodyInputStream = response.getBody();
             ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream()) {
            bodyInputStream.transferTo(byteArrayOutputStream);
            this.body = byteArrayOutputStream.toString(StandardCharsets.UTF_8);
        }
    }

    ClientHttpResponse getTheResponse() {
        return theResponse;
    }

    String getBody() {
        return body;
    }
}