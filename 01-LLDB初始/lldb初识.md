### LLDB 初始

LLDB 是一个有着 REPL 的特性和 C++ ,Python 插件的开源调试器。LLDB 绑定在 Xcode 
内部，存在于主窗口底部的控制台中。调试器允许你在程序运行的特定时暂停它，你可以查看变量的值，执行自定的指令，并且按照你所认为合适的步骤来操作程序的进展。



#### 1 expression  简写为e

* 执行一个表达式 
* 动态修改当前线程堆栈变量的值

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"alex",@"apple",@"bounce",@"age"];
    
    
    NSString * a = arr[1];
    NSString * b = arr[1];
    NSString * c = arr[1];
    NSString * d = arr[1];
    
    NSLog(@"%@",a);
    NSLog(@"%@",b);
    NSLog(@"%@",c);
    NSLog(@"%@",d);
}


// 打一个断点 使用e a 控制台输出信息如下 执行一个表示式
2019-01-16 10:52:57.050546+0800 SK_LLDB1[5881:64197] apple
(lldb) e a
(__NSCFConstantString *) $0 = 0x000000010183c090 @"apple"

    // 动态的修改c 的值 进行打印结果
    (lldb) e c = @"change_C"
(NSTaggedPointerString *) $2 = 0xb753a84c25bc65ea @"change_C"
2019-01-16 10:58:32.358539+0800 SK_LLDB1[5881:64197] change_C
    
    
    


```





#### 2 po & p

* `po`的作用为打印对象。`po`命令会尝试调用对象的 `description` 方法来取得对象信息。

使我们调试的时候能获得可读性更强，更全面的信息

*  p`即是`print`，也是`expression --`的缩写，与`po`不同，它不会打出对象的详细信息，只会打印出一个$符号，数字，再加上一段地址信息。打印对象的时候我们也可以指定特定格式

```objective-c
// x 十六进制打印
// d 十进制打印
// u 无符号十进制打印
// o 八进制打印
// t 二进制形式打印
// f 浮点数打印

(lldb) p/x a
(__NSCFConstantString *) $3 = 0x0000000105080090 @"apple"
(lldb) p/d a
(__NSCFConstantString *) $4 = 4379377808 @"apple"
```





#### 3  bt  

backtrace thread  打印当前线程完整的堆栈信息

使用frame select 指令进行查看任何一个堆栈的信息

frame 是帧，其实就是当前程序的堆栈

使用frame variable 展示当前作用域下的参数和局部变量



```objective-c
(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x00000001090cd63c SK_LLDB1`-[ViewController viewDidLoad](self=0x00007fd75fc100d0, _cmd="viewDidLoad") at ViewController.m:30
    frame #1: 0x000000010e2ba4e1 UIKitCore`-[UIViewController loadViewIfRequired] + 1186
    frame #2: 0x000000010e2ba940 UIKitCore`-[UIViewController view] + 27
    frame #3: 0x000000010e911c53 UIKitCore`-[UIWindow addRootViewControllerViewIfPossible] + 122
    frame #4: 0x000000010e91236e UIKitCore`-[UIWindow _setHidden:forced:] + 294
    frame #5: 0x000000010e9255c0 UIKitCore`-[UIWindow makeKeyAndVisible] + 42
    frame #6: 0x000000010e8d2833 UIKitCore`-[UIApplication _callInitializationDelegatesForMainScene:transitionContext:] + 4595
    frame #7: 0x000000010e8d7c2f UIKitCore`-[UIApplication _runWithMainScene:transitionContext:completion:] + 1623
    frame #8: 0x000000010e0f64e9 UIKitCore`__111-[__UICanvasLifecycleMonitor_Compatability _scheduleFirstCommitForScene:transition:firstActivation:completion:]_block_invoke + 866
    frame #9: 0x000000010e0ff29c UIKitCore`+[_UICanvas _enqueuePostSettingUpdateTransactionBlock:] + 153
    frame #10: 0x000000010e0f6126 UIKitCore`-[__UICanvasLifecycleMonitor_Compatability _scheduleFirstCommitForScene:transition:firstActivation:completion:] + 233
    frame #11: 0x000000010e0f6ae0 UIKitCore`-[__UICanvasLifecycleMonitor_Compatability activateEventsOnly:withContext:completion:] + 1085
    frame #12: 0x000000010e0f4cb5 UIKitCore`__82-[_UIApplicationCanvas _transitionLifecycleStateWithTransitionContext:completion:]_block_invoke + 795
    frame #13: 0x000000010e0f495f UIKitCore`-[_UIApplicationCanvas _transitionLifecycleStateWithTransitionContext:completion:] + 435
    frame #14: 0x000000010e0f9a90 UIKitCore`__125-[_UICanvasLifecycleSettingsDiffAction performActionsForCanvas:withUpdatedScene:settingsDiff:fromSettings:transitionContext:]_block_invoke + 584
    frame #15: 0x000000010e0fa80e UIKitCore`_performActionsWithDelayForTransitionContext + 100
    frame #16: 0x000000010e0f97ef UIKitCore`-[_UICanvasLifecycleSettingsDiffAction performActionsForCanvas:withUpdatedScene:settingsDiff:fromSettings:transitionContext:] + 221
    frame #17: 0x000000010e0fe93a UIKitCore`-[_UICanvas scene:didUpdateWithDiff:transitionContext:completion:] + 392
    frame #18: 0x000000010e8d644e UIKitCore`-[UIApplication workspace:didCreateScene:withTransitionContext:completion:] + 515
    frame #19: 0x000000010e47ad09 UIKitCore`-[UIApplicationSceneClientAgent scene:didInitializeWithEvent:completion:] + 357
    frame #20: 0x0000000115ae62da FrontBoardServices`-[FBSSceneImpl _didCreateWithTransitionContext:completion:] + 448
    frame #21: 0x0000000115af1443 FrontBoardServices`__56-[FBSWorkspace client:handleCreateScene:withCompletion:]_block_invoke_2 + 271
    frame #22: 0x0000000115af0b3a FrontBoardServices`__40-[FBSWorkspace _performDelegateCallOut:]_block_invoke + 53
    frame #23: 0x000000010bd4a602 libdispatch.dylib`_dispatch_client_callout + 8
    frame #24: 0x000000010bd4db78 libdispatch.dylib`_dispatch_block_invoke_direct + 301
    frame #25: 0x0000000115b25ba8 FrontBoardServices`__FBSSERIALQUEUE_IS_CALLING_OUT_TO_A_BLOCK__ + 30
    frame #26: 0x0000000115b25860 FrontBoardServices`-[FBSSerialQueue _performNext] + 457
    frame #27: 0x0000000115b25e40 FrontBoardServices`-[FBSSerialQueue _performNextFromRunLoopSource] + 45
    frame #28: 0x000000010a3b1721 CoreFoundation`__CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__ + 17
    frame #29: 0x000000010a3b0f93 CoreFoundation`__CFRunLoopDoSources0 + 243
    frame #30: 0x000000010a3ab63f CoreFoundation`__CFRunLoopRun + 1263
    frame #31: 0x000000010a3aae11 CoreFoundation`CFRunLoopRunSpecific + 625
    frame #32: 0x0000000112b251dd GraphicsServices`GSEventRunModal + 62
    frame #33: 0x000000010e8d981d UIKitCore`UIApplicationMain + 140
    frame #34: 0x00000001090cd770 SK_LLDB1`main(argc=1, argv=0x00007ffee6b31fa8) at main.m:14
    frame #35: 0x000000010bdc0575 libdyld.dylib`start + 1
    frame #36: 0x000000010bdc0575 libdyld.dylib`start + 1

(lldb) frame select 2
frame #2: 0x000000010e2ba940 UIKitCore`-[UIViewController view] + 27
UIKitCore`-[UIViewController view]:
    0x10e2ba940 <+27>: movq   0x124e729(%rip), %rsi     ; "_existingView"
    0x10e2ba947 <+34>: movq   %rbx, %rdi
    0x10e2ba94a <+37>: movq   %r14, %rax
    0x10e2ba94d <+40>: popq   %rbx
    
(lldb) frame variable
(ViewController *) self = 0x00007fd75fc100d0
(SEL) _cmd = "viewDidLoad"
(__NSArrayI *) arr = 0x00006000029b9650 @"4 elements"
(__NSCFConstantString *) a = 0x00000001090cf090 @"apple"
(__NSCFConstantString *) b = 0x00000001090cf090 @"apple"
(__NSCFConstantString *) c = 0x00000001090cf090 @"apple"
(__NSCFConstantString *) d = 0x00000001090cf090 @"apple"    
```



#### 4 设置断点

 1 直接在界面上进行设置断点进行编辑 

![](https://img03.sogoucdn.com/app/a/100520146/731F78D3C100114C434BB28A8C899C42)

* 添加condition，一般用于多次调用的函数或者循坏的代码中，在作用域内达到某个条件，才会触发程序暂停

* 忽略次数，这个很容易理解，在忽略触发几次后再触发暂停

* 添加Action，为这个断点添加子命令、脚本、shell命令

* 自动继续，配合上面的添加Action，我们就可以不用一次又一次的暂停程序进行调试来查询某些值（大型程序中断一次还是会有卡顿），直接用Action将需要的信息打印在控制台，一次性查看即可。



2  在xcode --debug--breakpoints 中进行设置

![](https://img03.sogoucdn.com/app/a/100520146/B84A0D9EE1CDEE856F89140C2ACF760C)



* Add Exception Breakpoint

  异常断点，TableView的数据源与UI操作不一致，或者容器插入了nil的指针，将消息传至野指针，都会导致程序的crash，并且LLDB输出的信息不是很友好。加上异常断点，能够使程序在抛出异常的栈自动暂停，可直接定位导致抛出异常的代码。

* Add Symbolic Breakpoint

  符号断点。Symbolic Breakpoint 为符号断点。有时候，我们并不清楚程序会在什么情况下调用某一个函数，那我们可以通过符号断点来获取调用该函数时的程序堆栈。



3 全局断点的设置

点击Add Symbolic Breakpoint  设置两次

第一次输入这个表达式 

```objective-c
-[NSException raise]
```

```objective-c

// 第二次输入次表示式 设置断点
objc_exception_throw
```

​	





