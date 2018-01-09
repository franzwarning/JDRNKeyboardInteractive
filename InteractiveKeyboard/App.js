/**
* Sample React Native App
* https://github.com/facebook/react-native
* @flow
*/

import React from 'react';
import {
    Platform,
    StyleSheet,
    Text,
    View,
    FlatList,
    TouchableOpacity,
    TextInput,
    KeyboardAvoidingView,
    NativeModules,
    NativeEventEmitter,
    Animated,
} from 'react-native';

const instructions = Platform.select({
    ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
    android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

const items = 'Curae enim quam cum sem suspendisse neque ipsum lacus taciti eleifend at hendrerit malesuada tristique lacinia tellus nam ante morbi rhoncus fames vulputate elementum nisl laoreet diam vestibulum inceptos ornare dictumst eget donec sed aliquet augue hac nibh nec lectus penatibus elit vivamus iaculis vel nulla leo vitae turpis arcu potenti congue himenaeos odio justo dolor suscipit aliquam sodales euismod magna convallis auctor rutrum primis semper litora sollicitudin ut lorem massa vehicula commodo tincidunt facilisi duis aenean molestie urna montes mi risus posuere condimentum fringilla magnis metus pharetra fusce et faucibus scelerisque sociosqu natoque velit tempus conubia sociis dapibus'

export default class App extends React.PureComponent{
    constructor(props) {
        super(props)
        this.state = {
            text: '',
            keyboardY: new Animated.Value(0),
        }
        this.renderItem = this.renderItem.bind(this)
        this.showKeyboard = this.showKeyboard.bind(this)

        const myModuleEvt = new NativeEventEmitter(NativeModules.KeyboardManager)
        myModuleEvt.addListener('KeyboardUpdated', (data) => {
            Animated.spring(this.state.keyboardY, {
                toValue: data.payload - 736
            }).start()
        })
    }

    showKeyboard() {

    }

    renderItem(item) {
        return (
            <View key={item.index}>
                <Text style={{ textAlign: 'left' }}>{item.item.item}</Text>
            </View>
        )
    }

    render() {
        return (
            <View style={styles.container}>
                <TouchableOpacity
                    onPress={this.showKeyboard}
                    style={{ width: '100%', backgroundColor: '#ffffff', marginTop: 20, flex: 0, zIndex: 1000 }}
                >
                    <View style={{ backgroundColor: '#ffffff', width: '100%', height: 50, flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                        <Text>Press Me</Text>
                    </View>
                </TouchableOpacity>
                <Animated.View style={{
                    position:'absolute',
                    top: 70,
                    left: 0,
                    right: 0,
                    bottom: 50,
                    transform: [{ translateY: this.state.keyboardY }]
                }}
                >
                    <FlatList
                        style={{ width: '100%', flex: 1 }}
                        data={items.split(' ').map((item, index) => ({ item, key: index }))}
                        renderItem={this.renderItem}
                        keyboardDismissMode={'interactive'}
                    />
                </Animated.View>
                <Animated.View style={{
                    position:'absolute',
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 50,
                    transform: [{ translateY: this.state.keyboardY }]
                }}>
                    <TextInput
                        onChangeText={(text) => this.setState({ text })}
                        value={this.state.text}
                        placeholder={'Enter Text here'}
                        style={{
                            height: 50,
                            backgroundColor: 'gray',
                        }}
                    />
                </Animated.View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'flex-start',
        backgroundColor: '#F5FCFF',
        position: 'relative',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
    },
});
