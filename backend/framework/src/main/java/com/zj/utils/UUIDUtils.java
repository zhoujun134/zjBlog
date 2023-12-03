package com.zj.utils;

import lombok.extern.slf4j.Slf4j;

import java.util.UUID;

@Slf4j
public class UUIDUtils {

    public static synchronized String getUuidString() {
        UUID uuid = UUID.randomUUID();
        String uuidString = uuid.toString();
        return uuidString.replace("-", "");
    }
}
