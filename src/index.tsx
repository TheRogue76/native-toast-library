import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'native-toast-library' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const NativeToastLibrary = NativeModules.NativeToastLibrary
  ? NativeModules.NativeToastLibrary
  : new Proxy(
      {},
      {
        get() {
          throw new Error(LINKING_ERROR);
        },
      }
    );

export function show(text: string) {
  return NativeToastLibrary.show(text);
}
