package cn.ky.jzk.util;

public interface GlobalConstant {
    // 订单创建状态常量
    Integer CREATE_ORDER_STATUS = 1;

    //  订单发货状态常量
    Integer TRANSPORT_ORDER_STATUS = 2;

    // 订单接受状态常量
    Integer RECIEVE_ORDER_STATUS = 3;

    // 数据库处理成功
    String SQL_SUCCESS = "Success";

    // 请求处理成功
    String REQUEST_SUCCESS = "Success!";

    // 创建订单区块链
    String CREATE_ORDER_NODE_CHAIN = "Insert into order with block chain hash code.";
}
