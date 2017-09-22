//
//  SJBPrivateDeclare.h
//  Pods
//
//  Created by 李翔宇 on 15/12/30.
//
//

#ifndef SJBPrivateDeclares_h
#define SJBPrivateDeclares_h

/**
 *  Benchmarking（用于测量效率的一段代码）
 *  用于测量一块代码的效率。
 *
 *  @param count  代码块运行次数
 *  @param ^block block
 *
 *  @return 平均时间（毫微秒）
 */
extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

#endif /* SJBPrivateDeclares_h */
