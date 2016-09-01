#ifndef DART_SHARED_LIB
#define DART_SHARED_LIB 1
#endif
#include <cstring>
#include <cctype>
#include "dart_api.h"
using namespace std;

// Forward declaration of ResolveName function.
Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* auto_setup_scope);

DART_EXPORT Dart_Handle cstring_Init(Dart_Handle parent_library) {
  if (Dart_IsError(parent_library))
    return parent_library;

  Dart_Handle result_code = Dart_SetNativeResolver(parent_library, ResolveName, NULL);

  if (Dart_IsError(result_code))
    return result_code;

  return Dart_Null();
}

Dart_Handle HandleError(Dart_Handle handle) {
  if (Dart_IsError(handle)) {
    Dart_PropagateError(handle);
  }
  return handle;
}

void dartStrcmp(Dart_NativeArguments arguments) {
  const char *str1, *str2;

  HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &str1));
  HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 1), &str2));

  Dart_Handle result = HandleError(Dart_NewInteger(strcmp(str1, str2)));
  Dart_SetReturnValue(arguments, result);
}

void dartStrncmp(Dart_NativeArguments arguments) {
  const char *str1, *str2;
  int64_t len;

  HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &str1));
  HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 1), &str2));
  HandleError(Dart_IntegerToInt64(Dart_GetNativeArgument(arguments, 2), &len));

  Dart_Handle result = HandleError(Dart_NewInteger(strncmp(str1, str2, len)));
  Dart_SetReturnValue(arguments, result);
}

void dartCompareChar(Dart_NativeArguments arguments) {
    const char *str1, *str2;
    
    HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &str1));
    HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 1), &str2));
    
    Dart_Handle result;
    
    if (str1[0] == str2[0])
        result = HandleError(Dart_True());
    else result = HandleError(Dart_False());
    
    Dart_SetReturnValue(arguments, result);
}

void dartIsAlnum(Dart_NativeArguments arguments) {
    const char *ch;
    HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &ch));
    
    Dart_Handle result;
    
    if (isalnum(ch[0])) {
        result = HandleError(Dart_True());
    } else result = HandleError(Dart_False());
    
    Dart_SetReturnValue(arguments, result);
}

void dartIsAlpha(Dart_NativeArguments arguments) {
    const char *ch;
    HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &ch));
    
    Dart_Handle result;
    
    if (isalpha(ch[0])) {
        result = HandleError(Dart_True());
    } else result = HandleError(Dart_False());
    
    Dart_SetReturnValue(arguments, result);
}

void dartIsDigit(Dart_NativeArguments arguments) {
    const char *ch;
    HandleError(Dart_StringToCString(Dart_GetNativeArgument(arguments, 0), &ch));
    
    Dart_Handle result;
    
    if (isdigit(ch[0])) {
        result = HandleError(Dart_True());
    } else result = HandleError(Dart_False());
    
    Dart_SetReturnValue(arguments, result);
}

Dart_NativeFunction ResolveName(Dart_Handle name, int argc, bool* auto_setup_scope) {
  // If we fail, we return NULL, and Dart throws an exception.
  if (!Dart_IsString(name)) return NULL;
  const char* cname;
  HandleError(Dart_StringToCString(name, &cname));

  if (strcmp("_dartStrcmp", cname) == 0)
    return dartStrcmp;
  else if (strcmp("_dartStrncmp", cname) == 0)
    return dartStrncmp;
  else if (strcmp("_dartCompareChar", cname) == 0)
      return dartCompareChar;
  else if (strcmp("_dartIsAlnum", cname) == 0)
      return dartIsAlnum;
  else if (strcmp("_dartIsAlpha", cname) == 0)
      return dartIsAlpha;
  else if (strcmp("_dartIsDigit", cname) == 0)
      return dartIsDigit;
  else return NULL;
}
