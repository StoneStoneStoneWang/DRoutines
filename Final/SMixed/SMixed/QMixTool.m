//
//  QMixTool.m
//  QMDemo
//
//  Created by 张文军 on 2018/9/25.
//  Copyright © 2018年 张文军. All rights reserved.
//

#import "QMixTool.h"

@interface QMixTool ()

@property(nonatomic,copy)NSString *mixPath;
@property(nonatomic,strong)NSFileManager *fm;

@end

@implementation QMixTool

#pragma mark - 生命周期 Life Circle

+(instancetype)defaultMixTool{
    static QMixTool *obj;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj=[[self alloc]init];
    });
    return obj;
}

#pragma mark - 控制器生命周期 ViewController Life Circle

#pragma mark - 公开的方法 public Methods

+(BOOL)mixJTZ {
    
    if ([[NSBundle mainBundle].bundlePath containsString:@"threestonewang"]) {
        
        return [self mix4Path:@"/Users/threestonewang/Desktop/所有/工作/新的包/凡岛网络-文化商城/凡岛网络-文化商城/Code/Mix/Mixed.h"];
    } else if ([[NSBundle mainBundle].bundlePath containsString:@"zhangli"]) {
        
        return [self mix4Path:@"/Users/zhangli/Documents/SourceTree/SRoutinesKit/FrameWork/Code/Mix/Mixed.h"];
    }
    
    return false;
}
//
+(BOOL)mix4Path:(NSString *)path{
    return [[self defaultMixTool] mix4Path:path];
}

#pragma mark - 私有的方法 private Methods
-(BOOL)mix4Path:(NSString *)path{
    NSAssert(path, @"mixPath不能为nil");
//    NSAssert([NSBundle.mainBundle.bundlePath containsString:@"Simulator"], @"该方法只能在模拟器中执行");
    NSAssert([self.fm fileExistsAtPath:path], @"%@不存在",path);
    self.mixPath = path;
    NSDictionary *mixDict = [self getReplaceDict:path];
    return [self replace:mixDict];
}

-(NSDictionary *)getReplaceDict:(NSString *)path{
    
    NSMutableDictionary *mdict = [NSMutableDictionary new];
    
    NSString *content = [NSString stringWithContentsOfFile:path encoding:4 error:nil];
    NSArray *lines = [content componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        if ([line containsString:@"#define "]) {
            NSRange range = [line rangeOfString:@"#define "];
            range = [line rangeOfString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(range.location+range.length, line.length-range.length-range.location)];
            range.length = line.length-range.location;
            NSString *temp = [line substringFromIndex:range.location];
            if (mdict[temp]) {
                NSLog(@"%@ 已存在 %@",temp,line);
            }
            mdict[temp] = [NSString stringWithFormat:@" %@",self.randString];
        }
    }
    return [mdict copy];
    
}

-(BOOL)replace:(NSDictionary *)mixDict{
    
    NSMutableString *content = [NSMutableString stringWithContentsOfFile:self.mixPath encoding:4 error:nil];
    [mixDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [content replaceOccurrencesOfString:key withString:obj options:1 range:NSMakeRange(0, content.length)];
    }];
    return [content writeToFile:self.mixPath atomically:YES encoding:4 error:nil];
}

-(NSString *)randString{
    
    NSString *chars = @"zxcvbnmasdfghjklpoiuytrewqQWERTYUIOPLKJHGFDSAZXCVBNM_1234567890";
    int length = 8+arc4random()%3;
    NSMutableString *mstring = [[NSMutableString alloc] initWithString:[chars substringWithRange:NSMakeRange(arc4random()%(chars.length-10), 1)]];
    for (int i = 1; i<length; i++) {
        [mstring appendString:[chars substringWithRange:NSMakeRange(arc4random()%chars.length, 1)]];
    }
    return mstring.description;
}

#pragma mark - 代理方法 delegate

#pragma mark - 数据源代理 datesource

#pragma mark - 触摸事件 touch event

#pragma mark - setter

#pragma mark - 懒加载 getter
-(NSFileManager *)fm{
    if (_fm == nil) {
        _fm = [NSFileManager defaultManager];
    }
    return _fm;
}


@end
