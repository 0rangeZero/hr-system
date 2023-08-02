package com.czl.system.test;

import com.czl.system.utils.ChineseCharToEnUtil;

public class TestPingyin {

    public static void main(String[] args) {
        String s = ChineseCharToEnUtil.getFirstSpell("下面强");
        System.out.println(s);
    }

}
