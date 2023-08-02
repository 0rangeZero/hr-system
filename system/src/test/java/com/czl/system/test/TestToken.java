package com.czl.system.test;

import com.czl.system.utils.JwtHelper;

public class TestToken {

    public static void main(String[] args) {
        String username = JwtHelper.getUsername("eyJhbGciOiJIUzUxMiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAAAKtWKi5NUrJScgwN8dANDXYNUtJRSq0oULIyNLMwNrewNDcz1VEqLU4t8kxRsjKCMPMSc1OBWkBMpVoAQt1dM0EAAAA.e3x1DEA9wQYdm9NiG4hmP0iY8v4AW6QIfvD6OOpdUmTtDQLHrcgBNwsikcKGXtgD-dsy7jNtqSeADTkEzL4xGQ");
        System.out.println(username);
    }

}
