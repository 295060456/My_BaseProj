
typedef void(^NoResultBlock)(void);
typedef void(^MKDataBlock)(id data);
typedef void(^TwoMKDataBlock)(id data,id data2);
typedef void(^ThreeMKDataBlock)(id data,id data2,id data3);
typedef void(^FourMKDataBlock)(id data,id data2,id data3,id data4);
typedef void(^FiveMKDataBlock)(id data,id data2,id data3,id data4,id data5);
typedef void(^SixMKDataBlock)(id data,id data2,id data3,id data4,id data5,id data6);
typedef void(^SevenMKDataBlock)(id data,id data2,id data3,id data4,id data5,id data7);
typedef void(^EightMKDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8);
typedef void(^NineMKDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9);
typedef void(^TenMKDataBlock)(id data,id data2,id data3,id data4,id data5,id data7,id data8,id data9,id data10);

typedef void(^MMDataBlock)(id firstArg,...);//第一个参数写：有多少个实际参数 用NSNumber表示 @1
