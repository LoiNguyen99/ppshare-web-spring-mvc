/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.loinv.powerpoin_share_v1.utils;

import com.loinv.powerpoin_share_v1.daos.SlideDAO;
import java.text.Normalizer;
import java.util.regex.Pattern;
import org.apache.log4j.Logger;

/**
 *
 * @author Loi Nguyen
 */
public class URLUtils {

    public static String covertStringToURL(String str) throws Exception {
        String temp = Normalizer.normalize(str, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        return pattern.matcher(temp).replaceAll("").toLowerCase().replaceAll(" ", "-").replaceAll("đ", "d");
    }
}
