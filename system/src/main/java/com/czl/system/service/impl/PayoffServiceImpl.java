package com.czl.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.czl.model.system.Payoff;
import com.czl.system.mapper.PayoffMapper;
import com.czl.system.service.PayoffService;
import org.springframework.stereotype.Service;

@Service
public class PayoffServiceImpl extends ServiceImpl<PayoffMapper, Payoff> implements PayoffService {

}
