NSString *ToNSString(char* string) {
    return [NSString stringWithUTF8String:string];
}

/// https://developer.apple.com/documentation/uikit/uiapplication/1622952-canopenurl?language=objc
bool _IOSCanOpenURL (char* url) {
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:ToNSString(url)]];
}